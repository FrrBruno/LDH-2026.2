`define STATE_CLOSED 2'b00
`define STATE_CLOSING 2'b01
`define STATE_OPEN 2'b10
`define STATE_OPENING 2'b11

module fsm_gate_ctrl(
	input rst,
	input clk,
	//sinais de controle
	input user_button,
	input star_stop,
	input end_stop,
	//saidas
	output motor_power,
	output motor_direction
	
	
);
	reg [1:0] state;
	reg [1:0] nextStage;
	
	//Motor de estados
	always @(posedge clk)begin
		if(rst) begin // reset síncrono
			state <= `STATE_CLOSED
		end else begin
			sate <= nextState;
		end
	end
	
	// Lógica de transição
	always @(*) begin
		case(state)
			`STATE_CLOSED: begin
				if(user_button = 1'b0) begin
					nextState = `STATE_CLOSED;
				end else begin
					nestState = `STATE_OPENING;
				end
			end
			`STATE_OPENING: begin
				if(end_stop = 1'b0) begin
					nextState = `STATE_OPENING;
				end else begin
					nestState = `STATE_OPEN;
				end
			end
			`STATE_OPEN: begin
				if(end_stop = 1'b0) begin
					nextState = `STATE_OPEN;
				end else begin
					nestState = `STATE_CLOSING;
				end
			end
			`STATE_CLOSING: begin
				if(star_stop = 1'b0) begin
					nextState = `STATE_CLOSING;
				end else begin
					nestState = `STATE_CLOSED;
				end
			end
		endcase
	end
	
	// Lógica de saída
	
	always *() begin
	if(state==STATE_CLOSING || state==`STATE_OPENING)
		motor_power = 1;
	else
		motor_power = 0;
		
		if(state== `STATE_OPENING)
			motor_direction = 1;
		else
			motor_direction = 0;
	end
	
	//
	endmodule 