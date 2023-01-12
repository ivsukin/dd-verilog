module alu32(input logic [31:0] A, B, input logic [1:0] ALUControl,
             output logic [31:0] Result, output logic [3:0] Flags);

    logic [31:0] x1;
    logic [31:0] Sum;
    logic Cout;
 
    always_comb
    begin
        if (ALUControl[0]) x1 = ~B; else x1 = B;
        {Cout, Sum} = x1 + A + {31'b0, ALUControl[0]};
        case (ALUControl)
            2'b00: Result = Sum;
            2'b01: Result = Sum;
            2'b10: Result = A & B;
            2'b11: Result = A | B;
        endcase
        Flags[3] = Result[31];
        Flags[2] = Result == 0;
        Flags[1] = ~ALUControl[1] & Cout;
        Flags[0] = (~ (ALUControl[0] ^ A[31] ^ B[31])) & (A[31] ^ Sum[31]) & ~ALUControl[1];
    end
endmodule