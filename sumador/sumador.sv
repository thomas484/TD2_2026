`timescale 1ns/1ps
    
module sumador (
    input logic [3:0] a, 
    input logic [3:0] b, 
    output logic [4:0] suma
);

    always_comb begin
        suma = a + b;

    end 
    endmodule