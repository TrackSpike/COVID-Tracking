## Abstract
Our COVID-19 Tracking app deals with data from an ever expanding pool of data sources. In order to properly analyse all this incoming data we need to have a singular format that all data is in.

## Key Points
1. All data must be in JSON format, each file should be a list with each child being its own data entry.
2. A **source** is a platform that provides data, example Instagram or Snapchat.
3. An **entry** is a more flexible definition. It is anything that could link one person to another. This could be an Instagram DM, the fact that person A follows person B or even a view on someone's snapchat story.
4. Each entry consists of **fields**, these fields are split into required and optional. All required fields must be filled out for the entry to be valid.

## Field List
### Required
* Source - The source that the entry came from.
* Time - The time that the interaction took place, in unix timestamp.
* Person - The other person, **not** the user who installed the app.
* Type - The type of entry data, this could be Instagram DM, Follower ect. See below for keyword list. The weight of the communication will be pulled from a separate JSON file.

### Optional
These will changed based on the source.
The idea behind these optional fields is to provide information is needed but it is not guaranteed to be there.

## Example
~~~
"data": [
   {
      "source":"instagram",
      "time":"2020-09-10T18:32:31+00:00",
      "person":"user3",
      "type":"instagram_dm"
   },
   {
      "source":"instagram",
      "time":"2020-09-10T13:34:08+00:00",
      "person":"user",
      "type":"instagram_dm"
   },
   {
      "source":"instagram",
      "time":"2020-09-10T02:11:12+00:00",
      "person":"user 5",
      "type":"instagram_dm"
   },
   {
      "source":"instagram",
      "time":"2020-09-09T21:17:15+00:00",
      "person":"user8",
      "type":"instagram_dm"
   },
   {
      "source":"instagram",
      "time":"2020-09-09T19:27:53+00:00",
      "person":"user7",
      "type":"instagram_dm"
   }
]
~~~
