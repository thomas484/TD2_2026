module ArchivoDeRegistro (
input logic clk, we3,
input logic [2:0] a1, a2, a3, 
output logic [3:0] d1, d2,
input logic [3:0] d3
);
//creo el arreglo bidimensional
logic [3:0] mem[7:0]; 
//lectura inmediata 
assign d1 = mem[a1];
assign d2 = mem[a2];
//escritura síncrona 
always_ff @(posedge clk) begin
    if(we3) mem[a3] <= d3; 
end
endmodule 