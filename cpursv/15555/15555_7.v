
module acl_work_group_dispatcher  #(parameter  WIDTH = 32, NUM_COPIES = 1, RUN_FOREVER = 0)
  (input  clock,
   input  resetn,
   input  start,
   input  [(-1)+WIDTH:0] num_groups[1+1:0],
   input  [(-1)+WIDTH:0] local_size[1+1:0],
   input  [NUM_COPIES-1:0] stall_in,
   output [NUM_COPIES-1:0] valid_out,
   output reg [(-1)+WIDTH:0] group_id_out[1+1:0],
   output reg [(-1)+WIDTH:0] global_id_base_out[1+1:0],
   output start_out,
   output reg dispatched_all_groups);

  reg  started;
  reg  delayed_start;
  reg  [(-1)+WIDTH:0] max_group_id[1+1:0];
  reg  [(-1)+WIDTH:0] group_id[1+1:0];
  wire last_group_id[1+1:0];

  assign last_group_id[0] = group_id[0] == max_group_id[0];
  assign last_group_id[1] = group_id[1] == max_group_id[1];
  assign last_group_id[1+1] = group_id[1+1] == max_group_id[1+1];
  wire 
       last_group = (last_group_id[1+1] & last_group_id[0]) & last_group_id[1];

  wire group_id_ready;

  wire bump_group_id[1+1:0];

  assign bump_group_id[0] = 1'b1;
  assign bump_group_id[1] = last_group_id[0];
  assign bump_group_id[1+1] = last_group_id[0] && last_group_id[1];
  
  always @(posedge clock or negedge resetn)
      begin
        if (~resetn) 
          begin
            group_id[0] <= {WIDTH{1'b0}};
            group_id[1] <= {WIDTH{1'b0}};
            group_id[1+1] <= {WIDTH{1'b0}};
            global_id_base_out[0] <= {WIDTH{1'b0}};
            global_id_base_out[1] <= {WIDTH{1'b0}};
            global_id_base_out[1+1] <= {WIDTH{1'b0}};
            max_group_id[0] <= {WIDTH{1'b0}};
            max_group_id[1] <= {WIDTH{1'b0}};
            max_group_id[1+1] <= {WIDTH{1'b0}};
            started <= 1'b0;
            delayed_start <= 1'b0;
            dispatched_all_groups <= 1'b0;
          end
        else if (start) 
          begin
            group_id[0] <= {WIDTH{1'b0}};
            group_id[1] <= {WIDTH{1'b0}};
            group_id[1+1] <= {WIDTH{1'b0}};
            global_id_base_out[0] <= {WIDTH{1'b0}};
            global_id_base_out[1] <= {WIDTH{1'b0}};
            global_id_base_out[1+1] <= {WIDTH{1'b0}};
            max_group_id[0] <= num_groups[0]-2'b01;
            max_group_id[1] <= num_groups[1]+(0-2'b01);
            max_group_id[1+1] <= num_groups[1+1]-2'b01;
            started <= 1'b1;
            delayed_start <= started;
            dispatched_all_groups <= 1'b0;
          end
        else 
          begin
            if ((stall_in & started) != ({NUM_COPIES{1'b1}} & ~dispatched_all_groups)) 
              begin
                if (bump_group_id[0]) 
                  group_id[0] <= last_group_id[0] ? {WIDTH{1'b0}} : (group_id[0]+2'b01);
                  
                if (bump_group_id[1]) 
                  group_id[1] <= last_group_id[1] ? {WIDTH{1'b0}} : (2'b01+group_id[1]);
                  
                if (bump_group_id[1+1]) 
                  group_id[1+1] <= last_group_id[1+1] ? {WIDTH{1'b0}} : (group_id[1+1]+2'b01);
                  
                if (bump_group_id[0]) 
                  global_id_base_out[0] <= last_group_id[0] ? {WIDTH{1'b0}} : (global_id_base_out[0]+local_size[0]);
                  
                if (bump_group_id[1]) 
                  global_id_base_out[1] <= last_group_id[1] ? {WIDTH{1'b0}} : (global_id_base_out[1]+local_size[1]);
                  
                if (bump_group_id[1+1]) 
                  global_id_base_out[1+1] <= last_group_id[1+1] ? {WIDTH{1'b0}} : (local_size[1+1]+global_id_base_out[1+1]);
                  
                if (last_group && (RUN_FOREVER == 0)) dispatched_all_groups <= 1'b1;
                  
              end
              
            if (dispatched_all_groups) 
              begin
                started <= 1'b0;
                delayed_start <= 1'b0;
              end
              
          end
      end
  wire [NUM_COPIES-1:0] 
       single_one_from_stall_in = (stall_in+1'b1) & ~stall_in;

  assign group_id_ready = ~dispatched_all_groups & delayed_start;
  assign start_out = start;
  assign group_id_out = group_id;
  assign valid_out = {NUM_COPIES{group_id_ready}} & single_one_from_stall_in;
endmodule

