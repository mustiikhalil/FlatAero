#include <iostream>
#include <string>

#include "JSON.h"
#include "variables.h"

namespace flat {

class FLAT {
 private:
  Parser parser;
  std::string gen_code;
  int inden_lvl = 0;

  void incrementIndentation() { inden_lvl += 2; }
  void decrementIndentation() {
    if (inden_lvl) inden_lvl -= 2;
  }

  void write(const std::string field_name, const std::string value,
             std::string &text) {
    text +=
        (std::string(inden_lvl, ' ') + "- " + field_name + ": " + value + "\n");
  }

  /// Taken from  flatbuffers writing format to json
  template<typename T> std::string PrintScalar(T val, const Type &type) {
    if (IsBool(type.base_type)) { return val != 0 ? "true" : "false"; }
    if (type.enum_def) {
      const auto &enum_def = *type.enum_def;
      if (auto ev = enum_def.ReverseLookup(static_cast<int64_t>(val))) {
        return ev->name;
      }
    }
    return flatbuffers::NumToString(val);
  }

  template<typename T> static T GetFieldDefault(const FieldDef &fd) {
    T val;
    auto check = flatbuffers::StringToNumber(fd.value.constant.c_str(), &val);
    (void)check;
    return val;
  }

  // Generate text for a scalar field.
  template<typename T>
  std::string GenField(const FieldDef &fd, const Table *table, bool fixed) {
    return PrintScalar(
        fixed ? reinterpret_cast<const Struct *>(table)->GetField<T>(
                    fd.value.offset)
              : table->GetField<T>(fd.value.offset, GetFieldDefault<T>(fd)),
        fd.value.type);
  }

  std::string ReadScalarFields(const FieldDef fd, const Table *table,
                               const StructDef &struct_def, const bool fixed) {
    switch (fd.value.type.base_type) {
      case flatbuffers::BASE_TYPE_NONE:
        return GenField<uint8_t>(fd, table, fixed);
      case flatbuffers::BASE_TYPE_UTYPE:
        return GenField<uint8_t>(fd, table, fixed);
      case flatbuffers::BASE_TYPE_BOOL: return GenField<bool>(fd, table, fixed);
      case flatbuffers::BASE_TYPE_CHAR:
        return GenField<int8_t>(fd, table, fixed);
      case flatbuffers::BASE_TYPE_UCHAR:
        return GenField<uint8_t>(fd, table, fixed);
      case flatbuffers::BASE_TYPE_SHORT:
        return GenField<short>(fd, table, fixed);
      case flatbuffers::BASE_TYPE_USHORT:
        return GenField<ushort>(fd, table, fixed);
      case flatbuffers::BASE_TYPE_INT: return GenField<int>(fd, table, fixed);
      case flatbuffers::BASE_TYPE_UINT: return GenField<uint>(fd, table, fixed);
      case flatbuffers::BASE_TYPE_LONG:
        return GenField<int64_t>(fd, table, fixed);
      case flatbuffers::BASE_TYPE_ULONG:
        return GenField<uint64_t>(fd, table, fixed);
      case flatbuffers::BASE_TYPE_FLOAT:
        return GenField<float>(fd, table, fixed);
      case flatbuffers::BASE_TYPE_DOUBLE:
        return GenField<double>(fd, table, fixed);
      default: return "UNKNOWN";
    }
  }

  std::string ReadFields(const FieldDef fd, const Table *table,
                         const StructDef &struct_def, const bool fixed) {
    std::string text;
    switch (fd.value.type.base_type) {
      case flatbuffers::BASE_TYPE_STRING: {
        auto val = table->GetPointer<const void *>(fd.value.offset);
        auto s = reinterpret_cast<const String *>(val);
        flatbuffers::EscapeString(s->c_str(), s->size(), &text, true, true);
        return text;
      }
      case flatbuffers::BASE_TYPE_STRUCT: {
        std::string text = "\n";
        auto val = flatbuffers::IsStruct(fd.value.type)
                       ? table->GetStruct<const void *>(fd.value.offset)
                       : table->GetPointer<const void *>(fd.value.offset);
        std::string type =
            flatbuffers::IsStruct(fd.value.type) ? "Struct" : "Table";
        GenerateBody(reinterpret_cast<const Table *>(val),
                     *fd.value.type.struct_def, text, type);
        return text.substr(0, text.size() - 1) + "";
      }
      default: return ReadScalarFields(fd, table, struct_def, fixed);
    }
  }

  const Table *GetRoot(const void *flatbuffer) {
    return parser.opts.size_prefixed
               ? flatbuffers::GetSizePrefixedRoot<Table>(flatbuffer)
               : flatbuffers::GetRoot<Table>(flatbuffer);
  }

  void GenerateBody(const Table *table, const StructDef &struct_def,
                    std::string &text, const std::string &body_type) {
    write(body_type, struct_def.name + " -", text);
    incrementIndentation();
    for (auto it = struct_def.fields.vec.begin();
         it < struct_def.fields.vec.end(); ++it) {
      auto field = **it;
      auto is_present =
          struct_def.fixed || table->CheckField(field.value.offset);
      if (is_present && !field.deprecated) {
        std::string value =
            ReadFields(field, table, struct_def, struct_def.fixed);
        write(field.name, value, text);
      }
    }
    decrementIndentation();
  }

  void GenerateFlat(const Table *table, const StructDef &struct_def) {
    std::string text;
    GenerateBody(table, struct_def, text, "Root");
    gen_code += text;
    decrementIndentation();
    gen_code += "----";
  }

 public:
  FLAT(const std::string &table) {
    auto ok = parser.Parse(table.c_str());
    if (!ok) { throw "Couldn't parse schema"; }
  }

  std::string parse(const void *flatbuffer) {
    gen_code = "";
    auto root = GetRoot(flatbuffer);
    GenerateFlat(root, *parser.root_struct_def_);
    return gen_code;
  }
};
}  // namespace flat
