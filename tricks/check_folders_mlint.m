% get the root dir to investigate
root = get_root_dir();

% get all files in the repository
files = dir(fullfile(root, '**\*.m'));

% put the names into a string variable
temp = string({files.folder; files.name});

% combine into fullpaths
fullnames = temp.join(filesep, 1);

% pass to the mlinter
checkcode(fullnames);