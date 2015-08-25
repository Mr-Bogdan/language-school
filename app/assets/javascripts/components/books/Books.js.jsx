var Books  = React.createClass({
  mixins: [GetCurrentUserId],

  getInitialState: function () {
    return {
      books: [],
      current_user_id: ""
    };
  },

  componentWillMount: function() {
    this.setState({current_user_id: this.getCurrentUserId()});
  },

  getData: function() {
    var books = new Bb.Collections.Books();
    books.fetch({
      success: function(collection, response, options) {
        this.setState({books: collection.toJSON()})
      }.bind(this),
      error: function(collection, response, options) {
      }.bind(this)
    });
  },

  componentDidMount: function () {
    this.getData();
  },
  
  render: function () {
    var booksList = this.state.books.map(function (book) {
      return (<Link to={'/books/' + book.id} className="list-group-item" key={book.id}>
        <h4 className="list-group-item-heading">{book.title}</h4>
        <p className="list-group-item-text">{book.description}</p>
        <p className="list-group-item-text">{book.user_id}</p>
        </Link>);
});
    return (
      <div className='container'>
        <h1>Books list</h1>
        <div>{booksList}</div>
        {this.state.current_user_id ? <NewBookLink/> : false}
      </div>
    ); 
  }
});


