#include <iostream>

#include MODULEHEADER

#include "verilated.h"
#include "verilated_vcd_c.h"

#define MAX_TICKS 40

static std::unique_ptr<VerilatedVcdC> trace{new VerilatedVcdC};
static std::unique_ptr<VerilatedContext> ctx{new VerilatedContext};

typedef MODULE testbench;
static testbench *tb;

static vluint64_t ts = 0;

void tick() {
  tb->a ^= 1;
  tb->eval();
  trace->dump(ts);
  ts++;
}

int main(int argc, char** argv) {
  ctx->commandArgs(argc, argv);
  ctx->traceEverOn(true);
  tb = new testbench{ctx.get()};

  #ifdef TRACE
  tb->trace(trace.get(), 99);
  trace->open("wave.vcd");
  #endif

  tb->reset = 1;
  tick();
  tb->reset = 0;
  while (ts < MAX_TICKS) {
    tick();
  }

  #ifdef TRACE
  trace->close();
  #endif
  
  delete tb;
  return 0;
}
