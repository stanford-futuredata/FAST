function paths = set_paths()
    rel_path = '../../';
    addpath(rel_path);
    paths = get_paths(rel_path); 
    addpath(paths);
end 
