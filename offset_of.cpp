#include <string>
#include <optional>
#include <cstddef>
#include <utility>

using Payload = std::string;
using MaybePayload = std::optional<Payload>;

class NoPayloadException {};

size_t offsetof_cargo();

class Airplane {
  MaybePayload hold;
  struct Cargo {
    MaybePayload operator=(Payload crate) {
      if (!host()->hold) {
        host()->hold = std::move(crate); return {};
      }
      return {std::move(crate)};
    }
    operator Payload() {
      if (!host()->hold) throw NoPayloadException{};
      return *std::exchange(host()->hold, {});
    }

    Airplane const* host() const {
      auto offset   = offsetof_cargo();
      auto fixed    =
        reinterpret_cast<char const*>(this) - offset;
      auto airplane = reinterpret_cast<Airplane const*>(fixed);
      return airplane;
    }

    Airplane* host() {
      auto offset   = offsetof_cargo();
      auto fixed    =
        reinterpret_cast<char*>(this) - offset;
      auto airplane = reinterpret_cast<Airplane*>(fixed);
      return airplane;
    }
    static constexpr size_t offsetof_cargo() {
      return std::integral_constant<size_t, offsetof(Airplane, cargo)>::value;
    }
  };
public:
  Cargo cargo;

} airplane;



int main() {
  Airplane airplane;
  airplane.cargo = std::string("cargo");
  std::string x = airplane.cargo;
}
