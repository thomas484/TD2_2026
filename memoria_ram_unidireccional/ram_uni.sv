module memoryRamUni #(parameter N = 6, M = 32)(
    input logic clk, we, 
    input logic [M-1:0] data_in, 
    input logic [N-1:0] address, 
    output logic [M-1:0] data_out
);
//creo una matriz de memoria de 2^N palabras de M bits
logic [M-1:0] mem [2**N-1:0]; 
always_ff @(posedge clk) begin
    if (we) begin
        mem[address] <= data_in;
    end 
end
assign data_out = mem[address]; //si we es 0, la memooria está en modo de lectura, si we es 1 en modo de escritura. 
endmodule