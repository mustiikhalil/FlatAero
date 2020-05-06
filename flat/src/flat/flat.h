#ifndef flat_h
#define flat_h

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

  void write(const std::string field_name, std::string &text,
             const std::string value) {
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

  std::string ReadScalarFields(const FieldDef &fd, const Table *table,
                               const StructDef &struct_def,
                               const uint8_t *prev_val, const bool fixed) {
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
      default: return GetOffset(fd, table, struct_def, prev_val, fixed);
    }
  }

  std::string GetOffset(const FieldDef &fd, const Table *table,
                        const StructDef &struct_def, const uint8_t *prev_val,
                        const bool fixed) {
    const void *val = nullptr;
    if (fixed) {
      val = reinterpret_cast<const Struct *>(table)->GetStruct<const void *>(
          fd.value.offset);
    } else {
      val = IsStruct(fd.value.type)
                ? table->GetStruct<const void *>(fd.value.offset)
                : table->GetPointer<const void *>(fd.value.offset);
    }
    return ReadFields(val, fd.value.type, prev_val, -1);
  }

  std::string ReadFields(const void *val, const Type &type,
                         const uint8_t *prev_val,
                         flatbuffers::soffset_t vector_index) {
    std::string text;
    switch (type.base_type) {
      case flatbuffers::BASE_TYPE_STRING: {
        auto s = reinterpret_cast<const String *>(val);
        flatbuffers::EscapeString(s->c_str(), s->size(), &text, false, false);
        return text;
      }
      case flatbuffers::BASE_TYPE_STRUCT: {
        std::string text = "\n";
        std::string type_ = flatbuffers::IsStruct(type) ? "Struct" : "Table";
        incrementIndentation();
        GenerateBody(reinterpret_cast<const Table *>(val), *type.struct_def,
                     text, type_);
        decrementIndentation();
        return text.substr(0, text.size() - 1) + "";
      }
      case flatbuffers::BASE_TYPE_UNION: {
        auto union_type_byte = *prev_val;
        if (vector_index >= 0) {
          auto type_vec =
              reinterpret_cast<const flatbuffers::Vector<uint8_t> *>(
                  prev_val +
                  flatbuffers::ReadScalar<flatbuffers::uoffset_t>(prev_val));
          union_type_byte =
              type_vec->Get(static_cast<flatbuffers::uoffset_t>(vector_index));
        }
        auto enum_val = type.enum_def->ReverseLookup(union_type_byte, true);
        if (enum_val) {
          return ReadFields(val, enum_val->union_type, nullptr, -1);
        } else {
          return "UNKNOWN";
        }
      }
      case flatbuffers::BASE_TYPE_ARRAY: {
          
          return "[]";
      }
      case flatbuffers::BASE_TYPE_VECTOR: return "[]";
      default: return "UNKNOWN";
    }
  }

  const Table *GetRoot(const void *flatbuffer) {
    return parser.opts.size_prefixed
               ? flatbuffers::GetSizePrefixedRoot<Table>(flatbuffer)
               : flatbuffers::GetRoot<Table>(flatbuffer);
  }

  void GenerateBody(const Table *table, const StructDef &struct_def,
                    std::string &text, const std::string &body_type) {
    write(body_type, text, struct_def.name + " -");
    incrementIndentation();
    const uint8_t *ptr = nullptr;
    for (auto it = struct_def.fields.vec.begin();
         it < struct_def.fields.vec.end(); ++it) {
      FieldDef &field = **it;
      auto is_present =
          struct_def.fixed || table->CheckField(field.value.offset);
      if (is_present && !field.deprecated) {
        auto value =
            ReadScalarFields(field, table, struct_def, ptr, struct_def.fixed);
        write(field.name, text, value);
      }
      if (struct_def.fixed) {
        ptr = reinterpret_cast<const uint8_t *>(table) + field.value.offset;
      } else {
        ptr = table->GetAddressOf(field.value.offset);
      }
    }
    decrementIndentation();
  }

  void GenerateFlat(const Table *table, const StructDef &struct_def) {
    std::string text;
    GenerateBody(table, struct_def, text, "RootType");
    gen_code += text;
    decrementIndentation();
    gen_code += "----";
  }

 public:
  FLAT(const std::string &table);
  std::string parse(const void *flatbuffer);
};

}  // namespace flat
#endif /* flat_h */
