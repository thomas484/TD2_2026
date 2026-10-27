
module decoder_2to4 (
    input  logic [1:0] sel,    // Entradas de selección
    input  logic       enable, // Habilitación
    output logic [3:0] out     // Salidas
);

    always_comb begin
        if (!enable) begin
            out = 4'b0000;
        end else begin
            case (sel)
                2'b00:   out = 4'b0001;
                2'b01:   out = 4'b0010;
                2'b10:   out = 4'b0100;
                2'b11:   out = 4'b1000;
                default: out = 4'b0000;
            endcase
        end
    end

endmodule