module tb_transfer;

	integer f;
	reg 	reset;
	reg	clk;
	reg 		signed	[11:0] x;
	wire 		signed	[11:0] y;

	always #5 clk = ~clk;	//clock 1MHz
		
	bw2_filter dut (
	.reset(reset), .clk(clk), .x(x), .y(y)
	);
		
		always begin
			#10	$monitor("%d, %d", x, y);
			$fwrite(f, "%d, %d\n", x,y);
		end
		
		//stimuli
		initial begin
			f = $fopen("output.csv","w");
			clk = 0;
			reset = 1;
			#10;	//1 clock cycle
			reset = 0;
			x = 	2048,
					3251,
					3995,
					3251,
					2048,
					844,
					100,
					100,
					844;
			#10 x = 12'sd0;
			#10 x = 12'sd1203;
			#10 x = 12'sd1947;
			#10 x = 12'sd1203;
			#10 x = 12'sd0;
			#10 x = -12'sd1204;
			#10 x = -12'sd1948;
			#10 x = -12'sd1948;
			#10 x = -12'sd1204;
			
			$fclose(f);
			$finish;
		end
	
endmodule
