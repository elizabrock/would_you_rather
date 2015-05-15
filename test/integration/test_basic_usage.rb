require_relative '../test_helper'

class TestBasicUsage < Minitest::Test
  def test_manage_wrong_argument_given
    shell_output = ""
    expected_output = ""
    IO.popen('./would_you_rather blah') do |pipe|
      expected_output = "[Help] Run as: ./would_you_rather manage\n"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_manage_multiple_arguments_given
    shell_output = ""
    expected_output = ""
    IO.popen('./would_you_rather manage blah') do |pipe|
      expected_output = "[Help] Run as: ./would_you_rather manage\n"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_manage_argument_given_then_exit
    shell_output = ""
    expected_output = ""
    IO.popen('./would_you_rather manage', 'r+') do |pipe|
      expected_output = <<EOS
1. Add a scenario
2. List all scenarios
3. Exit
EOS
      pipe.puts "3"
      expected_output << "Peace Out!\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end
end
