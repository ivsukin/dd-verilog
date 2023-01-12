module mux8(input logic [7:0] data, input logic [2:0] control,
    output logic result);
    assign result = data[control];
endmodule