# vim-goimpl

`:GoAddTags` command for Go

## Usage

When you have struct

```go
type Foo struct {
     Name  string
     Value int
}
```

Add json/db tags to the struct under the cursor

```
:GoAddTags json db
```

```go
type Foo struct {
    Name string `json:"name" db:"name"`
    Age  int    `json:"age" db:"age"`
}

```

## Installation


For [vim-plug](https://github.com/junegunn/vim-plug) plugin manager:

```viml
Plug 'mattn/vim-goaddtags'
```

## License

MIT

## Author

Yasuhiro Matsumoto (a.k.a. mattn)

