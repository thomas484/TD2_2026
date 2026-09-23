`timescale 1ns/1ps

module mux #(
    parameter WIDTH = 4
)(
    input  logic [WIDTH-1:0] in0,   // Entrada 0
    input  logic [WIDTH-1:0] in1,   // Entrada 1
    input  logic [WIDTH-1:0] in2,   // Entrada 2
    input  logic [WIDTH-1:0] in3,   // Entrada 3
    input  logic [1:0]       sel,   // Selector de 2 bits
    output logic [WIDTH-1:0] out    // Salida seleccionada
);

    // Lógica combinacional para la selección
    always_comb begin
        case (sel)
            2'b00:   out = in0;
            2'b01:   out = in1;
            2'b10:   out = in2;
            2'b11:   out = in3;
            default: out = '0;
        endcase
    end

endmodule