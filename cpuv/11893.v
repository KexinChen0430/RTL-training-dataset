module master(
  input wire reset_n,        
  input wire clk,           
  input wire en,            
  input wire start,         
  input wire stop,          
  input wire mode,          
  input wire [6:0] address, 
  input wire [7:0] registor,
  inout reg sda,            
  inout reg scl,            
  output reg [7:0]data_out  
  );
  reg [3:0] master_state;    
  reg [3:0] master_counter;  
  reg sda_en;                
  reg sda_out;               
  reg scl_en;                
  wire sda_in;               
  wire scl_in;               
  parameter WAIT = 0;
  parameter START = 1;
  parameter ADDRESS = 2;
  parameter MODE = 3;
  parameter ADDRESS_ACK = 4;
  parameter WRITE_DATA = 5;
  parameter READ_DATA = 6;
  parameter WRITE_ACK = 7;
  parameter READ_ACK = 8;
  parameter READ_NACK = 9;
  parameter STOP = 10;
  parameter DONE = 11;
  parameter BAD = 15;
  assign sda = (sda_en) ? sda_out ? 1'bz : 1'b0 : 1'bz; 
  assign sda_in = sda;                                   
  assign scl = (scl_en) ? (clk) ? 1'bz : 1'b0 : 1'bz;    
  assign scl_in = scl;                                   
  always@(posedge clk or negedge reset_n)
    begin
      if( !reset_n )    
        begin
          data_out <= 8'bz;
        end
      else
        begin
          if(master_state == READ_DATA) 
            begin
              data_out <= {data_out[6:0], sda_in}; 
            end
          else if((master_state == READ_ACK) || (master_state == READ_NACK))
            begin
              data_out <= data_out;
            end
          else    
            begin
              data_out <= 8'bz;
            end
        end
    end
  always@(master_state or negedge reset_n or master_counter)
    begin
      if( !reset_n )  
        begin
          sda_en <= 0;
          sda_out <= 0;
          scl_en <= 0;
        end
      else
        begin
          case( master_state ) 
            WAIT:     
              begin
                sda_en <= 0;
                sda_out <= 0;
                scl_en <= 0;
              end
            START:    
              begin
                sda_en <= 1;
                sda_out <= 0;
                scl_en <= 0;
            end
            ADDRESS:  
              begin
                sda_en <= 1;
                sda_out <= address[6 - master_counter];
                scl_en <= 1;
              end
            MODE:     
             begin
                sda_en <= 1;
                sda_out <= mode;
                scl_en <= 1;
              end
            ADDRESS_ACK:    
              begin
                sda_en <= 0;
                sda_out <= 0;
                scl_en <= 1;
              end
            WRITE_DATA:     
              begin
                sda_en <= 1;
                sda_out <= registor[7 - master_counter];
                scl_en <= 1;
              end
            READ_DATA:    
              begin
                sda_en <= 0;
                sda_out <= 0;
                scl_en <= 1;
              end
            WRITE_ACK:    
              begin
                sda_en <= 0;
                sda_out <= 0;
                scl_en <= 1;
              end
            READ_ACK:     
              begin
                sda_en <= 1;
                sda_out <= 0;
                scl_en <= 1;
              end
            READ_NACK:  
              begin
                sda_en <= 1;
                sda_out <= 1;
                scl_en <= 1;
              end
            STOP:       
              begin
                sda_en <= 1;
                sda_out <= 0;
                scl_en <= 1;
              end
            DONE:       
              begin
                sda_en <= 0;
                sda_out <= 0;
                scl_en <= 0;
              end
            BAD:      
              begin
                sda_en <= 0;
                sda_out <= 0;
                scl_en <= 0;
              end
          endcase
        end
    end
  always@(negedge clk or negedge reset_n)
    begin
      if(!reset_n)  
        begin
          master_state <= WAIT;
          master_counter <= 1'b0;
        end
      else
        case(master_state) 
          WAIT:     
            begin
              if(start && en )
                begin
                  master_state <= START;
                  master_counter <= 1'b0;
                end
              else
                begin
                  master_state <= WAIT;
                  master_counter <= 1'b0;
                end
            end
          START:    
            begin
              master_state <= ADDRESS;
              master_counter <= 1'b0;
            end
          ADDRESS:  
            begin
              if(master_counter < 6)
                begin
                  master_counter <= master_counter + 1'b1;
                  master_state <= ADDRESS;
                end
              else
                begin
                  master_state <= MODE;
                  master_counter <= 1'b0;
                end
            end
          MODE:     
            begin
              master_state <= ADDRESS_ACK;
              master_counter <= 1'b0;
            end
          ADDRESS_ACK:  
            begin
              if( !sda_in )
                begin
                  if( mode )
                    begin
                      master_state <= READ_DATA;
                      master_counter <= 1'b0;
                    end
                  else
                    begin
                      master_state <= WRITE_DATA;
                      master_counter <= 1'b0;
                    end
                end
              else
                begin
                  master_state <= STOP;
                  master_counter <= 0;
                end
            end
          WRITE_DATA:   
            begin
              if(master_counter < 7)
                begin
                  master_state <= WRITE_DATA;
                  master_counter <= master_counter + 1'b1;
                end
              else
                begin
                  master_state <= WRITE_ACK;
                  master_counter <= 1'b0;
                end
            end
          WRITE_ACK:    
            begin
              if( sda_in || stop )
                begin
                  master_state <= STOP;
                  master_counter <= 1'b0;
                end
              else
                begin
                  master_state <= WRITE_DATA;
                  master_counter <= 1'b0;
                end
            end
          READ_DATA:    
            begin
              if(master_counter < 7)
                begin
                  master_state <= READ_DATA;
                  master_counter <= master_counter + 1'b1;
                end
              else
                if( stop )
                  begin
                    master_state <= READ_NACK;
                    master_counter <= 1'b0;
                  end
                else
                  begin
                    master_state <= READ_ACK;
                    master_counter <= 1'b0;
                  end
            end
          READ_ACK:   
            begin
              master_state <= READ_DATA;
              master_counter <= 1'b0;
            end
          READ_NACK:  
            begin
              master_state <= STOP;
              master_counter <= 1'b0;
            end
          STOP:       
            begin
              master_state <= DONE;
              master_counter <= 1'b0;
            end
          DONE:       
            begin
              master_state <= DONE;
              master_counter <= 1'b0;
            end
          BAD:        
            begin
              master_state <= BAD;
              master_counter <= 1'b0;
            end
          default:    
            begin
              master_state <= BAD;
              master_counter <= 1'b0;
            end
       endcase
    end
endmodule