module srff (input logic clk, input logic s, input logic r,
  output logic q, output logic nq);

  assign nq = ~q;

  always_latch
  begin
    if (clk) 
      if (s & ~r) q = 1;
      else if (~s & r) q = 0;
  end
endmodule