#include <iostream>
#include <random>

#include MODULEHEADER

#include "verilated.h"
#include "verilated_vcd_c.h"

#define MAX_TICKS 100

static std::unique_ptr<VerilatedVcdC> trace{new VerilatedVcdC};
static std::unique_ptr<VerilatedContext> ctx{new VerilatedContext};

typedef MODULE testbench;
static testbench *tb;

static vluint64_t ts = 0;

void tick() {
  if (ts %4 == 0)
    tb->clk ^= 1;
  tb->eval();
  trace->dump(ts);
  ts++;
}

int main(int argc, char** argv) {
  std::random_device rd;
  std::mt19937 gen(rd());
  std::uniform_int_distribution<> distrib(0, 1);

  ctx->commandArgs(argc, argv);
  ctx->traceEverOn(true);
  tb = new testbench{ctx.get()};

  #ifdef TRACE
  tb->trace(trace.get(), 99);
  trace->open("wave.vcd");
  #endif

  tb->reset = 0;
  while (ts < MAX_TICKS) {
    if (tb->clk == 1) {
      tb->A = distrib(gen);
      tb->B = distrib(gen);
    }
    tick();
  }

  #ifdef TRACE
  trace->close();
  #endif
  
  delete tb;
  return 0;
}
