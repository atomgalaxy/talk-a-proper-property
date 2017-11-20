#include <utility>
#include <optional>
#include <string>
#include <cassert>

int main() {
  auto x = std::optional<std::string>{"blah"};
  auto y = std::exchange(x, {});
  assert(!x);
  assert(y == "blah");
}
