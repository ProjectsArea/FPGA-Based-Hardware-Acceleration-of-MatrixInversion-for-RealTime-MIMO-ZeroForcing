`timescale 1ns/1ps

module control_fsm(

    input clk,
    input reset,
    input start,

    output reg load_matrix,
    output reg normalize_pivot,
    output reg eliminate_row,
    output reg done,

    output reg [1:0] pivot_index,
    output reg [1:0] row_index

);

//////////////////////////////////////////////////
// STATE DEFINITIONS
//////////////////////////////////////////////////

localparam IDLE        = 3'd0;
localparam LOAD        = 3'd1;
localparam NORMALIZE   = 3'd2;
localparam ELIMINATE   = 3'd3;
localparam NEXT_PIVOT  = 3'd4;
localparam FINISH      = 3'd5;

reg [2:0] state;
reg [2:0] next_state;

//////////////////////////////////////////////////
// STATE REGISTER
//////////////////////////////////////////////////

always @(posedge clk or posedge reset)
begin
    if(reset)
        state <= IDLE;
    else
        state <= next_state;
end

//////////////////////////////////////////////////
// NEXT STATE LOGIC
//////////////////////////////////////////////////

always @(*)
begin
    case(state)

        IDLE:
        begin
            if(start)
                next_state = LOAD;
            else
                next_state = IDLE;
        end

        LOAD:
        begin
            next_state = NORMALIZE;
        end

        NORMALIZE:
        begin
            next_state = ELIMINATE;
        end

        ELIMINATE:
        begin
            if(row_index == 2'd3)
                next_state = NEXT_PIVOT;
            else
                next_state = ELIMINATE;
        end

        NEXT_PIVOT:
        begin
            if(pivot_index == 2'd3)
                next_state = FINISH;
            else
                next_state = NORMALIZE;
        end

        FINISH:
        begin
            next_state = IDLE;
        end

        default:
            next_state = IDLE;

    endcase
end

//////////////////////////////////////////////////
// OUTPUT LOGIC
//////////////////////////////////////////////////

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        load_matrix      <= 0;
        normalize_pivot  <= 0;
        eliminate_row    <= 0;
        done             <= 0;
        pivot_index      <= 0;
        row_index        <= 0;
    end

    else
    begin

        // Default outputs
        load_matrix     <= 0;
        normalize_pivot <= 0;
        eliminate_row   <= 0;
        done            <= 0;

        case(state)

            IDLE:
            begin
                pivot_index <= 0;
                row_index   <= 0;
            end

            LOAD:
            begin
                load_matrix <= 1;
            end

            NORMALIZE:
            begin
                normalize_pivot <= 1;
                row_index <= 0;
            end

            ELIMINATE:
            begin
                eliminate_row <= 1;

                if(row_index < 2'd3)
                    row_index <= row_index + 1;
            end

            NEXT_PIVOT:
            begin
                pivot_index <= pivot_index + 1;
                row_index   <= 0;
            end

            FINISH:
            begin
                done <= 1;
            end

        endcase
    end
end

endmodule