module cnt4(input logic clk, input logic reset, output logic [31:0] result);
    logic [31:0] state;

    assign result = state;

    always_ff @(posedge clk)
        if (reset) state = 0;
        else state += 4;
endmodule;
