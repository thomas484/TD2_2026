`timescale 1ns/1ps

module contador (
    input  logic       clk,
    input  logic       rst,
    output logic [3:0] cuenta
);

    // Bloque secuencial sensible al flanco de subida del reloj
    always_ff @(posedge clk) begin
        if (rst) begin
            cuenta <= 4'b0000; // Resetear la cuenta a cero
        end else begin
            cuenta <= cuenta + 1'b1; // Incrementar en 1
        end
    end

endmodule
