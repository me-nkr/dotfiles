local status = pcall(require, 'nomad')
if not status then
	return print('config not installed')
end
