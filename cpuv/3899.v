module demo_sound2(
	input clock, 
	output [7:0]key_code, 
	input k_tr 
);
	reg  [15:0]tmp; 
	wire  [15:0]tmpa; 
	reg   tr; 
	reg   [15:0]step; 
	wire  [15:0]step_r; 
	reg   [7:0]TT; 
	reg[5:0]st; 
	reg go_end; 
	always @(negedge k_tr or posedge clock) begin
		if (!k_tr) begin 
   			step=0; 
		   	st=0; 
   			tr=0; 
		end
		else if (step<step_r) begin 
  			case (st) 
  			0: st=st+1; 
  			1: begin tr=0; st=st+1;end 
  			2: begin tr=1;st=st+1;end 
  			3: if(go_end) st=st+1; 
  			4: begin st=0;step=step+1;end 
  			endcase
		end
	end
	wire  [7:0]key_code1=(
	);
	assign tmpa[15:0]=(
	);
	always @(step) begin
	end
	assign step_r=8;
	always @(negedge tr or posedge clock)begin
		if(!tr) begin tmp=0;go_end=0 ;end 
		else if (tmp>tmpa)go_end=1; 
		else tmp=tmp+1; 
	end
	assign key_code=(tmp<(tmpa-1))?key_code1:8'hf0;
endmodule