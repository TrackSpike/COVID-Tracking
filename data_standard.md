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
{
	"source": "Instagram",
	"person": "John",
	"type": "Instagram DM",
    "time": 1699923,
	"message": "Hello World"
}
~~~