#include <iostream>

extern "C" int val(int[],unsigned, unsigned=0);

int main() {
	int v[4] = {1,5,2,4};
	unsigned n = 4;
	std::cout << val(v,n) << std::endl;
	return 0;
}
