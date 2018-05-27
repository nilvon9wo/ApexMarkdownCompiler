public class MKDN_Markdown {
	private static MKDN_Markdown INSTANCE;
	MKDN_GEN_Generator generator;
	MKDN_SYN_Parser parser;
	MKDN_TKN_Tokenizer tokenizer;

    private MKDN_Markdown(
     		MKDN_GEN_Generator generator,
     		MKDN_SYN_Parser parser,
    		MKDN_TKN_Tokenizer tokenizer
    	){
    	this.generator = generator;
    	this.parser = parser;
    	this.tokenizer = tokenizer;
    }
    
    private MKDN_Markdown(){
    	this(
    		MKDN_GEN_Generator.getInstance(),
    		MKDN_SYN_Parser.getInstance(), 
    		MKDN_TKN_Tokenizer.getInstance()
    	);
    }
	
    public static MKDN_Markdown getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_Markdown();
    	} 
    	return INSTANCE; 
    }	 
	
    public String toHtml(String input) {
    	List<MKDN_TKN_Token> tokenList = this.tokenizer.tokenize(input);
    	MKDN_ND_Node node = this.parser.parse(tokenList); 
    	return this.generator.generate((MKDN_ND_BodyNode) node);
    }
}