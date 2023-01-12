// Resettable D flip-flop
module dffr(input logic clk, input logic reset, input logic d, output logic q);
    always_ff @(posedge clk, reset)
        if (reset) q = 0;
        else q = d;
endmodule;

// Settable D flip-flop
module dffs(input logic clk, input logic reset, input logic d, output logic q);
    always_ff @(posedge clk, reset)
        if (reset) q = 1;
        else q = d;
endmodule;

module task_h1_2(input logic a, input reset, output logic b, output logic ss2, output logic ss0,
    output logic nn1, output logic ss1);
    wire s2, s1, s0, n1;
    dffr d2(a, reset, s0, s2);
    dffr d1(a, reset, s2, s1);
    dffs d0(a, reset, s1, s0);
    dffr dn(~a, reset, s0, n1);
    assign ss2 = s2;
    assign ss0 = s0;
    assign ss1 = s1;
    assign nn1 = n1;
    assign b = n1 | s0;
endmodule;
