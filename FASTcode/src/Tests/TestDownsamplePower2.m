function [passed] = TestGetDownsamplePower2()

% Unit test for get_downsample_power_2.m
% passed = 1 if all tests pass, passed = 0 if any test fails

path(path,'~/Documents/research/similarity_search');

passed = logical(1);
passed = passed & (1 == get_downsample_power_2(1));
passed = passed & (2 == get_downsample_power_2(2));
passed = passed & (2 == get_downsample_power_2(3));
passed = passed & (4 == get_downsample_power_2(4));
passed = passed & (4 == get_downsample_power_2(5));
passed = passed & (4 == get_downsample_power_2(6));
passed = passed & (4 == get_downsample_power_2(7));
passed = passed & (8 == get_downsample_power_2(8));
passed = passed & (8 == get_downsample_power_2(9));
passed = passed & (64 == get_downsample_power_2(127));
passed = passed & (128 == get_downsample_power_2(128));
passed = passed & (128 == get_downsample_power_2(129));
passed = passed & (128 == get_downsample_power_2(200));
passed = passed & (128 == get_downsample_power_2(255));
passed = passed & (256 == get_downsample_power_2(256));
passed = passed & (256 == get_downsample_power_2(257));

end

