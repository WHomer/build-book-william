# Details

This project was designed to take in two json files storing the input of the first file as songs, users, and playlists.  The second file is designed to allow for changes which will modified in memory and then return the input file with the same format after the changes have been made. This project took roughly two and half hours to test and complete.

## Setup

1. Ruby should be installed. This was built and tested off of `ruby 3.0.3`
2. The gem `json` will need to be installed, `gem install 'json'`
3. All test files should be in the root directory of this project.

## Running

1. This program can be ran with `ruby runner.rb` it does take three arguements, however, the default files `input.json`, `change.json`, and `output.json` will be used if no arguements are passed.
2. To run with arguments pass only the file name and not the extention, only files formated as json will work. Example `ruby runner.rb input change output`
3. The last argument in the run statement will be the name of the output file and will have the Input files key/values with the requested changes declared in the Change file.

## JSON Format Examples

### Input.json

Allows only `users`, `playlists`, `songs`.

```json
{
  "users" : [
    {
      "id" : "1",
      "name" : "Albin Jaye"
    },
    {
      // ...
    }
  ],
  "playlists" : [
    {
      "id" : "1",
      "owner_id" : "2",
      "song_ids" : [
        "8",
        "32"
      ]
    },
    {
      // ...
    }
  ],
  "songs": [
    {
      "id" : "1",
      "artist": "Camila Cabello",
      "title": "Never Be the Same"
    },
    {
      // ...
    }
  ]
}
```

### Change.json

Allows only `add_song_to_playlist`, `add_playlist`, `remove_playlist` actions. You can include as many change types as you would like.

```json
{
  "changes": [
  {
    "type": "remove_playlist",
    "attributes": {
      "id": "3"
    }
  },
  {
    "type": "add_playlist",
    "attributes": {
      "id" : "54",
      "owner_id" : "2",
      "song_ids" : [
        "8",
        "32"
      ]
    }
  },
  {
    "type": "add_song_to_playlist",
    "attributes": {
      "song_id": "1",
      "playlist_id": "1"
    }
  }
  ]
}
```

### Output.json

Output file will be formated exactly as the input with the changes made.

```json
{
  "users" : [
    {
      "id" : "1",
      "name" : "Albin Jaye"
    },
    {
      // ...
    }
  ],
  "playlists" : [
    {
      "id" : "1",
      "owner_id" : "2",
      "song_ids" : [
        "8",
        "32"
      ]
    },
    {
      // ...
    }
  ],
  "songs": [
    {
      "id" : "1",
      "artist": "Camila Cabello",
      "title": "Never Be the Same"
    },
    {
      // ...
    }
  ]
}
```

## Design Considerations

This project was designed with OOP in mind while keeping classes contained to only have logic that each class should handle. The Spotify class was just used as a filler name based on the context of the example file. I tried to keep all classes exposing only the information needed and not allowing for any exposed writters/readers. I did however ignore the fact of mismatching id's and assumed all data was well formatted and consistant.

## Scaling The Application

To scale this application I believe it would be best store the results in a database as it will allow for better lookup times and may avoid the issue where data is only living in memory. Additionally, I think allowing for more of an API would allow for more real-time updates rather than batching the results in larger files.

Your README describes what changes you would need to make in order to scale this application to handle very large input files and/or very large changes files. Just describe these changes — please do not implement a scaled-up version of the application.
Your README includes any thoughts on design decisions you made that you think are appropriate.
Your README includes how long you spent on the project, and any other thoughts you might have or want to communicate.

## Additional Time

If I had additional time on this project I would complete the below items.

1. Write at minimum unit tests to cover the classes and their methods.
2. Break the three logical steps from the runner file either into it's own class or modules added to the Spotify class. This will allow for the ability to test and would have allowed to create it's own service object.
