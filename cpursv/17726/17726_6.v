
module acl_shift_register(clock,resetn,clear,enable,Q,D);

  parameter  WIDTH = 32;
  parameter  STAGES = 1;
  input  clock,resetn,clear,enable;
  input  [(0-1)+WIDTH:0] D;
  output [(0-1)+WIDTH:0] Q;
  wire clock,resetn,clear,enable;
  wire [(0-1)+WIDTH:0] D;
  reg  [(0-1)+WIDTH:0] stages[(0-1)+STAGES:0];

  
  generate
      if (STAGES == 0) 
        begin
          assign Q = D;
        end
      else 
        begin
          genvar istage;
          for (istage = 0; istage < STAGES; istage = 1+istage)
              begin : stages_loop
                
                always @(posedge clock or negedge resetn)
                    begin
                      if (!resetn) 
                        begin
                          stages[istage] <= {WIDTH{1'b0}};
                        end
                      else if (clear) 
                        begin
                          stages[istage] <= {WIDTH{1'b0}};
                        end
                      else if (enable) 
                        begin
                          if (istage == 0) 
                            begin
                              stages[istage] <= D;
                            end
                          else 
                            begin
                              stages[istage] <= stages[istage+(0-1)];
                            end
                        end
                        
                    end
              end
          assign Q = stages[(0-1)+STAGES];
        end
  endgenerate

endmodule

