module dc24(input logic [1:0] x, input logic en, output logic [3:0] y);
    always_comb
    if (en)
        case (x)
            2'b00: y = 4'b0001;
            2'b01: y = 4'b0010;
            2'b10: y = 4'b0100;
            2'b11: y = 4'b1000;
        endcase
    else y = 0;
endmodule;

module dc38(input logic [2:0] x, input logic en, output logic [7:0] y);
    logic [3:0] y1, y2;
    dc24 d1({x[0], x[1]}, x[2], y1);
    dc24 d2({x[0], x[1]}, ~x[2], y2);
    always_comb
    if (en) y = {y1, y2}; else y = 0;
endmodule;

module dc416(input logic [3:0] x, input logic en, output logic [15:0] y);
    logic [7:0] y1, y2;
    dc38 d1({x[0], x[1], x[2]}, x[3], y1);
    dc38 d2({x[0], x[1], x[2]}, ~x[3], y2);
    always_comb
    if (en) y = {y1, y2}; else y = 0;
endmodule;

module dc532(input logic [4:0] x, input logic en, output logic [31:0] y);
    logic [15:0] y1, y2;
    dc416 d1({x[0], x[1], x[2], x[3]}, x[4], y1);
    dc416 d2({x[0], x[1], x[2], x[3]}, ~x[4], y2);
    always_comb
    if (en) y = {y1, y2}; else y = 0;
endmodule;

module dc664(input logic [5:0] x, input logic en, output logic [63:0] y);
    logic [31:0] y1, y2;
    dc532 d1({x[0], x[1], x[2], x[3], x[4]}, x[5], y1);
    dc532 d2({x[0], x[1], x[2], x[3], x[4]}, ~x[5], y2);
    always_comb
    if (en) y = {y1, y2}; else y = 0;
endmodule;