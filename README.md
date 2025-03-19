# Bargain

Bargain is a Markdown parsing library for Elixir. It allows you to take markdown and return valid HTML.


### Features

**Parse the following**

- [x] Heading
- [x] Paragraphs
- [x] Links
- [x] Italics
- [x] Bold
- [x] Block Quote
- [x] Inline Code
- [x] Code Block
- [x] Horizontal Rules
- [ ] Lists
- [ ] Automatic Links
- [ ] Images


**Fix**

- [x] Just a link as text `[some](link)`
- [] trailing new line
- [] syntax type and returns in code blocks. 
example: ```bash
  swarms help
```
- [] Links in the middle of a paragraph, ex: For more documentation on the CLI [CLICK HERE](https://docs.swarms.world/en/latest/swarms/cli/main/)
- [] links with formatting

```
 - **High-performance**. Build scalable applications with minimal runtime overhead.
 - **Type-safe**. Use the full power of the Scala compiler to catch bugs at compile time.
 - **Concurrent**. Easily build concurrent apps without deadlocks, race conditions, or complexity.
```



Horizontal Rule

When a chuck of text, thought of as a paragraph comes in, if it starts with "---", insert <hr>


## MongoDB (migration to mongodb 5)
Whether you are using docker or you are running mongo directly on your development machine you will need to dump
and restore your data if you want to keep it. If you are running mongodb directly on your machine you will want to dump
the database and then upgrade to mongodb 5 and subsequently restore. It will be assumed that you can modify the commands
below to suite your needs.

If you are using docker compose to run mongodb you you can just run `docker-compose up -d` and once all the services
are running you can run the following commands to dump the data from the old mongo db and restore it to the new one.
Both versions of mongo will be running on their own ports during a period of transition so you can run the dump and
restore without needed to perform any other actions.
