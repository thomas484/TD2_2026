

module UnidadDeCorrimiento (
    input  logic [3:0] d, 
    input  logic [2:0] select, 
    output logic [3:0] y
);

    always_comb begin
        case (select)
            3'b000: y = d;                                              // Sin desplazamiento
            3'b001: y = d << 1;                                         // Shift left logical
            3'b010: y = $signed(d) >>> 1;                               // Shift right arithmetic
            3'b011: y = 4'b0000;                                        // Salida a cero
            3'b100: y = d;                                              // Pasante (Bypass)
            3'b101: y = (d << 1) | ((d & 4'b1000) >> 3);                // Rotate left sin d[3]
            3'b110: y = (d >> 1) | ((d & 4'b0001) << 3);                // Rotate right sin d[0]
            3'b111: y = d;                                              // Pasante (Bypass)
            default: y = 4'b0000;
        endcase
    end

endmodule