As Roku developer I want to have short-time living component, which will allow me to work with persistence storage.

AC:

Component should have two interface fields:
data(assocarray) - data passed to component to work with persistence storage(should include operation name as required field)
result(assocarray) - result of persistence storage invoking. Should contain success field for reflection operation success.
Component should support next operations(depends on action value):
Save passed information in provided section name(both should be in data field).
Read information from provided section name. This information should be put in result.
Delete one record (by given key) from provided section name.
Delete several records (by given keys) from provided section name
Clear whole section
Erase whole registry.
Component should be put into services folder and properly commented.
After setting result field state should be set to "DONE"