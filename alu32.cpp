#include <iostream>
#include <random>

#include MODULEHEADER

#include "verilated.h"
#include "verilated_vcd_c.h"

#define MAX_TICKS 20
#define ALU_ADD 0
#define ALU_SUB 1
#define ALU_AND 2
#define ALU_OR  3

#define FLAG_OVERFLOW 1
#define FLAG_CARRY    2
#define FLAG_ZERO     4
#define FLAG_NEGATIVE 8

static std::unique_ptr<VerilatedVcdC> trace{new VerilatedVcdC};
static std::unique_ptr<VerilatedContext> ctx{new VerilatedContext};

typedef MODULE testbench;
static testbench *tb;

static vluint32_t A, B, Result;
static unsigned int Control;
static unsigned int Flags;

void step() {
  tb->A = A;
  tb->B = B;
  tb->ALUControl = Control;
  tb->eval();
  Result = tb->Result;
  Flags = tb->Flags;
}

bool check(unsigned int f) {
  switch (Control) {
    case ALU_ADD: {
      if (Result != A + B) return false;
      break;
    }
    case ALU_SUB: {
      if (Result != A - B) return false;
      break;
    }
    case ALU_OR: {
      if (Result != (A | B)) return false;
      break;
    }
    case ALU_AND: {
      if (Result != (A & B)) return false;
      break;
    }
  }
  if (Flags != f) return false; 
  else return true;
}

void run_test(vluint32_t a, vluint32_t b, unsigned int op, unsigned int f) {
  A = a;
  B = b;
  Control = op;
  step();
  std::cout << "A = " << int(A) << ", B = " << int(B) << ", A";
  switch (Control) {
    case ALU_ADD: std::cout << " + "; break;
    case ALU_SUB: std::cout << " - "; break;
    case ALU_OR:  std::cout << " | "; break;
    case ALU_AND: std::cout << " & "; break;
  }
  std::cout << "B = " << int(Result) << std::endl;
  std::cout << "Flags: " << std::endl;
  std::cout << "  N = " << ((Flags & 8) >> 3);
  std::cout << "  Z = " << ((Flags & 4) >> 2);
  std::cout << "  C = " << ((Flags & 2) >> 1);
  std::cout << "  V = " << (Flags & 1) << std::endl;
  if (check(f)) std::cout << "\u001b[32mCorrect!\033[0m" << std::endl;
  else std::cout << "\u001b[31mIncorrect!\033[0m" << std::endl;
}

int main(int argc, char** argv) {
  ctx->commandArgs(argc, argv);
  ctx->traceEverOn(true);
  tb = new testbench{ctx.get()};

  #ifdef TRACE
  tb->trace(trace.get(), 99);
  trace->open("wave.vcd");
  #endif

  // Addition
  run_test(321432, 45354, ALU_ADD, FLAG_CARRY);
  run_test(321432, -45354, ALU_ADD, FLAG_CARRY);
  run_test(-321432, -45354, ALU_ADD, FLAG_NEGATIVE + FLAG_CARRY);
  run_test(2147483647, 1, ALU_ADD, FLAG_NEGATIVE + FLAG_OVERFLOW);
  run_test(3, -3, ALU_ADD, FLAG_ZERO + FLAG_CARRY);
  // Subtraction
  run_test(3236542, 432435, ALU_SUB, 0);
  run_test(3236542, 4236542, ALU_SUB, FLAG_NEGATIVE);
  run_test(-2147483648, 1, ALU_SUB, FLAG_OVERFLOW + FLAG_CARRY);
  run_test(3, 3, ALU_SUB, FLAG_ZERO + FLAG_CARRY);
  // OR
  run_test(43545, 5843, ALU_OR, 0);
  run_test(98433, -43, ALU_OR, FLAG_NEGATIVE);
  // AND
  run_test(12324, 4321, ALU_AND, 0);
  run_test(12343, -432, ALU_AND, 0);
  run_test(-132, -863, ALU_AND, FLAG_NEGATIVE);
  run_test(8, 4, ALU_AND, FLAG_ZERO);

  #ifdef TRACE
  trace->close();
  #endif
  
  delete tb;
  return 0;
}
