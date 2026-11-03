module seg_mult (
	input rst,
	input clk,
	//Dados
	input 	[3:0] a,
	input 	[3:0] b,
	output	[7:0] m
	//Entradas do usuario
	input start,
	//Saidas para o usuario
	output done 
);
	wire load, clear, zero;
	
	mult_fsm fsml (
		.rst(rst),
		.clk(clk),
		//sinais de controle
		.load(load),
		.clear(clear),
		//sinais de estado
		.zero(zero)
		//sinais de saida para o usuario
		.start(start)
		.done(done)
	);
	
	mult_datapath dp(
	.clk(clk),
		//dados
		.a(a),
		.b(b),
		.m(m),
		//sinais de controle
		.load(load),
		.clear(clear),
	//sinais de estado
		.zero(zero)
	);

endmodule
