module fsm2(input logic clk, reset,
    input logic A, B,
    output logic Q);
logic [2:0] state, nextstate;

parameter S0 = 3'b001;
parameter S1 = 3'b010;
parameter S2 = 3'b100;

always_ff @(posedge clk, posedge reset)
if (reset) state <= S0;
else       state <= nextstate;
always_comb
case (state)
    S0: if (A) nextstate = S1;
        else nextstate = S0;
    S1: if (B) nextstate = S2;
        else nextstate = S0;
    S2: nextstate = S0;
default: nextstate = S0;
endcase
assign Q = (state == S2);
endmodule
