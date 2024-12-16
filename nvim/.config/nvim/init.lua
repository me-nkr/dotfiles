local status, err = pcall(require, 'nomad')
if not status then
    print(err:gsub(": ", " -> \n"))
    print("\n")
	return print('config not installed')
end
