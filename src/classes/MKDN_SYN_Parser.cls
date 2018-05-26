public class MKDN_SYN_Parser {
	private static MKDN_SYN_Parser INSTANCE;
	private static final String PARAGRAPH_LIST = 'paragraphList';
	private static final String CONSUMED_QUANTITY = 'consumed';
    MKDN_SYN_BodyParser bodyParser;

    private MKDN_SYN_Parser(MKDN_SYN_BodyParser bodyParser) {
    	this.bodyParser = bodyParser;
    }
    
    private MKDN_SYN_Parser() {
    	this(MKDN_SYN_BodyParser.getInstance());
    }

    public static MKDN_SYN_Parser getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_SYN_Parser();
    	}
    	return INSTANCE;
    }
    
    public MKDN_ND_Node parse(List<MKDN_TKN_Token> tokenList) {
    	MKDN_ND_Node body = this.bodyParser.match(tokenList);
    	if (tokenList.size() != body.consumed) {
    		throw new MKDN_SYN_SyntaxException(
    			'Syntax Error: #' + body.consumed 
    			+ ' is not equal to the number of provided tokens (' + tokenList.size() + ')'
    		);
    	}
    	return body;
    }
    
}