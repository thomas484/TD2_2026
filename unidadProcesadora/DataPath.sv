`include "ArchivoDeRegistro.sv"
`include "ALU4Bits.sv"
`include "UnidadDeCorrimiento.sv"

module DataPath(
input logic clk, 
input logic [15:0] ctrl_word, 
input logic  [3:0] data_in, 
output logic [3:0] data_out, 
output logic [3:0] state_bits
);

//creo las salidas internas 
logic [2:0] a,b,d,h; 
logic [3:0] f, rega, regb, busa, busb, aluout, flags;
//HHHFFFFDDDBBBAAA creo la palabra de control
assign a = ctrl_word[2:0];
assign b = ctrl_word[5:3];
assign d = ctrl_word[8:6]; //selección de registro destino en el caso de escritura
assign f = ctrl_word[12:9];
assign h = ctrl_word[15:13];

//crea un registro de archivos usando una instanciación. 
ArchivoDeRegistro REG_file(clk, (d!=0), a, b, d, rega, regb, data_out); //el archivo de registro toma como entrada data_out cerrando el bucle

//creo la unidad aritmética lógica instanciandola
//pregunto si el archivo de registros tiene datos de salida disponible, sino tomo de la entrada
assign busa = ((a!=0) ? rega : data_in);
assign busb = ((b!=0) ? regb : data_in);
ALU4Bits alu_unit(busa, busb, f, aluout, flags);
always_ff @(posedge clk) begin
state_bits <= flags; 
end
//creo el modulo shifter 
UnidadDeCorrimiento shifter_unit(aluout, h, data_out);


endmodule