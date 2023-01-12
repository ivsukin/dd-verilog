#include <iostream>

#include MODULEHEADER

#include "verilated.h"
#include "verilated_vcd_c.h"

static std::unique_ptr<VerilatedVcdC> trace{new VerilatedVcdC};
static std::unique_ptr<VerilatedContext> ctx{new VerilatedContext};

typedef MODULE testbench;
static testbench *tb;

void init_x(int cnt) {
  tb->en = 1;
  tb->x = cnt;
}

void tick() {
  tb->eval();
}

bool check(int cnt) {
  init_x(cnt);
  tick();
  return true;
}

void run_tests() {
  for (int i = 0; i < 63; i++) {
    if (check(i)) std::cout << "\u001b[32mCorrect!\033[0m" << std::endl;
    else std::cout << "\u001b[31mIncorrect!\033[0m" << std::endl;
  }
}

int main(int argc, char** argv) {
  ctx->commandArgs(argc, argv);
  ctx->traceEverOn(true);
  tb = new testbench{ctx.get()};

  #ifdef TRACE
  tb->trace(trace.get(), 99);
  trace->open("wave.vcd");
  #endif

  run_tests();

  #ifdef TRACE
  trace->close();
  #endif
  
  delete tb;
  return 0;
}
