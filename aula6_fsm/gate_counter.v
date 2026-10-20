module gate_counter (
	input rst,
	input clk,
	input enable,
	input dir,
	output start_stop,
	output end_stop,
	output [9:0] led_bar
)

	reg [3:0] count;
	reg [3:0] nextCount;

	//Motor de estados
	always @(posedge clk) begin
		if(rst)
			state <= 0;
		else if(enable)
			state <= nextState;
	end
	
	//Lógica do próximo estado
	always @(*) begin
		if(count == 4'd9)
			if(dir=1)
				nextCount = count;
			else
				nextCount = count - 1;
		else if (count==0)
			if(dir=1)
				nextCount = count + 1;
			else
				nextCount = count;
		else
			if(dir = 1)
				nextCount = count + 1;
			else
				nextCount = count - 1;
	end
	
	//Lógica de saída
	always @(*) begin
		case (state)
			0:		led_bar = 0b0000000000;
			1:		led_bar = 0b0000000001;
			2:		led_bar = 0b0000000011;
			3:		led_bar = 0b0000000111;
			4:		led_bar = 0b0000001111;
			5:		led_bar = 0b0000011111;
			6:		led_bar = 0b0000111111;
			7:		led_bar = 0b0001111111;
			8:		led_bar = 0b0011111111;
			9:		led_bar = 0b0111111111;
			10:	led_bar = 0b1111111111;
		endcase
	end
	assign start_stop = (state==0);
	assign end_stop = (state==10);

endmodule
