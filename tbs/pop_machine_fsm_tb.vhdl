LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY pop_machine_fsm_tb IS
END ENTITY pop_machine_fsm_tb;

ARCHITECTURE arch_tb OF pop_machine_fsm_tb IS
    COMPONENT pop_machine_fsm IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            c : IN STD_LOGIC;
            s : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            d : OUT STD_LOGIC
        );
    END COMPONENT pop_machine_fsm;

    SIGNAL clk : STD_LOGIC;
    SIGNAL rst : STD_LOGIC;
    SIGNAL c : STD_LOGIC;
    SIGNAL s : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL a : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL d : STD_LOGIC;
BEGIN
    --Unit Under Test
    uut : pop_machine_fsm PORT MAP(
        clk => clk,
        rst => rst,
        c => c,
        s => s,
        a => a,
        d => d
    );

    test_pop_machine : PROCESS
    BEGIN
	--preco do refri = 2 reais = 200 centavos
        s <= b"11001000";
	
        rst <= '1',
            '0' AFTER 10 ns;
        clk <= '0', 
            '1' AFTER 20 ns,
            '0' AFTER 40 ns,
            '1' AFTER 60 ns,
            '0' AFTER 80 ns,
            '1' AFTER 100 ns,
            '0' AFTER 120 ns,
            '1' AFTER 140 ns,
            '0' AFTER 160 ns,
            '1' AFTER 180 ns,
            '0' AFTER 200 ns,
            '1' AFTER 220 ns,
            '0' AFTER 240 ns,
            '1' AFTER 260 ns,
	    '0' AFTER 280 ns,
	    '1' AFTER 300 ns,
	    '0' AFTER 320 ns,
	    '1' AFTER 340 ns,
	    '0' AFTER 360 ns,
	    '1' AFTER 380 ns,
	    '0' AFTER 400 ns,
	    '1' AFTER 420 ns,
	    '0' AFTER 440 ns,
	    '1' AFTER 460 ns,
	    '0' AFTER 480 ns;

        c <= '0',
            '1' AFTER 40 ns,
            '0' AFTER 340 ns;
	--preco: 50 centavos
        a <= b"00000000",
            b"00110010" AFTER 40 ns,
            b"00000000" AFTER 340 ns;
	wait;
    END PROCESS test_pop_machine;
END ARCHITECTURE arch_tb;
