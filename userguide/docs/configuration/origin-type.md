# Origin Types

An origin type for an event can be modified using Jiggle from **Event > Edit Origin...** menu. 
Since origin types are defined as database constraint, the list of origin types are supplied using Jiggle's configuration file.  

## Default Origin Types

The following origin types are always loaded by Jiggle unless the value of the property is set to an empty string.
This allows origin types to be loaded even when the configuration file does not include the list of origin types.

- origin.type.a=Amplitude
- origin.type.c=Centroid
- origin.type.d=Double Difference
- origin.type.h=Hypocenter
- origin.type.n=Non Locatable
- origin.type.u=Unknown

Since they are always loaded in by Jiggle, these origin types cannot be deleted from the Preference dialog or the configuration file. However, setting the description to an empty string removes the origin type from the drop-down list when editing an origin.

## Add Origin Type

Each origin type has a **Type** and a **Description**. 
Before adding a new type, check with your database administrator to verify that the **Type** exists in your database.
**Description** field is what is populated in drop-down list for a user selection when editing an event.

To add a new origin type:

1. Go to **Properties > Edit Properties...** and select the **Origin Types** tab.
1. Select **New...**.
1. Enter **Type** and **Description** of your origin type. **Type** is limited to two characters and **Description** is limited to 30 characters. 
1. Click **OK** to close the new origin type dialog box.
1. The new origin type should display in the table.
1. Click **OK** on the Preference dialog to save changes. Note: save changes to Jiggle properties file to persist changes.

 ![Adding a new origin type](../img/pref_origin_type_new.png "New Origin Type")

## Edit Origin Type

**Description** for an origin type can be modified as needed.

To edit a description:

1. Go to **Properties > Edit Properties...** and select the **Origin Types** tab.
1. Select an origin type from the list to edit.
1. Select **Edit...**. 
1. On the **Edit Origin Type** dialog, change the **Description**. Note: **Type** cannot be modified.  
1. Click **OK** to close the edit origin type dialog box. 
1. The origin type table should reflect the updated description.
1. Click **OK** on the Preference dialog to save changes. Note: save changes to Jiggle properties file to persist changes.

![Edit an origin type](../img/pref_origin_type_edit.png "Edit Origin Type")

## Delete Origin Type

Since Jiggle always populates the origin type list with defaults, the default origin types cannot be deleted from Jiggle using the preference dialog. 
Instead, if a default origin type should not display on the **Event > Edit Origin...** dialog for user selection, then the description for the type should be deleted and set to an empty string.  

To delete a custom origin type created in Jiggle (i.e. **Default** column is set to **No**):

1. Go to **Properties > Edit Properties...** and select the **Origin Types** tab.
1. Select an origin type from the list to delete.
1. Select **Delete...**.
1. Click **OK** on the confirmation dialog.
1. The origin type should no longer exist in the table.
1. Click **OK** on the Preference dialog to save changes. Note: save changes to Jiggle properties file to persist changes. 

![Delete an origin type](../img/pref_origin_type_delete.png "Delete Origin Type")

## Properties

Origin types are stored in the Jiggle properties file in the following format:

    origin.type.XX={description}

You should not have to define the origin types in your properties file to see them on Jiggle, but will see them once the Jiggle properties files is updated by Preference dialog. 

Also, keep in mind:

- **XX** is one or two character string for your origin type. For example, `origin.type.a`.
- `{description}` is the string displayed in drop-down list when editing an origin type for an event and can be up to 30 characters.
- When editing manually, use all lowercase to define your origin type name.
- Jiggle uses the **Type** for interacting with a database, but **Description** is shown on the drop-down list. 

