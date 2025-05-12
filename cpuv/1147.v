module kernel_clock_0_master_FSM (
  input  master_clk,                  
  input  master_reset_n,              
  input  master_waitrequest,          
  input  slave_read_request_token,    
  input  slave_write_request_token,   
  output reg master_read,             
  output reg master_read_done,        
  output reg master_write,            
  output reg master_write_done        
);
  reg [2:0] master_state;             
  reg [2:0] next_master_state;        
  reg next_master_read;               
  reg next_master_read_done;          
  reg next_master_write;              
  reg next_master_write_done;         
  always @(posedge master_clk or negedge master_reset_n) begin
    if (!master_reset_n) begin
      master_read_done <= 0;
    end else begin
      master_read_done <= next_master_read_done;
    end
  end
  always @(*) begin
    next_master_state = master_state;
    next_master_read = 0;
    next_master_read_done = master_read_done;
    next_master_write = 0;
    next_master_write_done = master_write_done;
    case (master_state)
      3'b001: begin
        if (slave_read_request_token) begin
          next_master_state = 3'b010; 
          next_master_read = 1;       
          next_master_write = 0;      
        end
        else if (slave_write_request_token) begin
          next_master_state = 3'b100; 
          next_master_read = 0;       
          next_master_write = 1;      
        end
      end
      3'b010: begin
        if (!master_waitrequest) begin
          next_master_state = 3'b001;       
          next_master_read_done = !master_read_done; 
          next_master_read = 0;             
        end else begin
          next_master_state = 3'b010;
          next_master_read_done = master_read_done;
          next_master_read = master_read;
        end
        next_master_write = 0;              
      end
      3'b100: begin
        if (!master_waitrequest) begin
          next_master_state = 3'b001;       
          next_master_write = 0;            
          next_master_write_done = !master_write_done; 
        end else begin
          next_master_state = 3'b100;
          next_master_write = master_write;
          next_master_write_done = master_write_done;
        end
        next_master_read = 0;               
      end
      default: begin
        next_master_state = 3'b001;
        next_master_write = 0;
        next_master_write_done = master_write_done;
        next_master_read = 0;
        next_master_read_done = master_read_done;
      end
    endcase
  end
endmodule