#include <optional>
#include <string>
#include <iostream>

using Payload = std::string;
using MaybePayload = std::optional<Payload>;

class Airplane {
  MaybePayload hold;
public:
  struct Cargo {
  } cargo;
} airplane;

union examine_ptr {
  Airplane::Cargo Airplane::* member;
  char byte_repr[sizeof(&Airplane::cargo)];
  uintptr_t int_repr;
  static_assert(sizeof(int_repr) == sizeof(byte_repr));
};

int main() {
  std::cout << "&Airplane::cargo: " << examine_ptr{&Airplane::cargo}.int_repr << "\n";
}
