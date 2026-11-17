`timescale 100ns/100ns

module tb_impulse_response;

	reg rst, clk;
	reg [11:0] x;
	wire [11:0] y;
	
	always #5 clk = ~clk; //Clock 1Mhz
	
	movavg_filter (
		.rst(rst), . clk(clk),
		.x(x), .y(y)
	);
	
	//Stimuli
	initial begin
		rst = 1;
		#15; //1,5 clock cycle
		rst = 0;
		x = 12'b100000000000;
		#10
		x = 12'd0;
		#50
		$finish;
	end
	
endmodule 