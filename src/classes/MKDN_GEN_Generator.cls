public class MKDN_GEN_Generator {
	private static MKDN_GEN_Generator INSTANCE;
	MKDN_VST_BodyVisitor bodyVisitor;

    private MKDN_GEN_Generator(MKDN_VST_BodyVisitor bodyVisitor){
    	this.bodyVisitor = bodyVisitor;
    }
    
    private MKDN_GEN_Generator(){
    	this(MKDN_VST_BodyVisitor.getInstance());
    }
	
    public static MKDN_GEN_Generator getInstance() {
    	if (INSTANCE == null) {
    		INSTANCE = new MKDN_GEN_Generator();
    	} 
    	return INSTANCE; 
    }	 
	
    public String generate(MKDN_ND_BodyNode astBodyNode) {
    	return this.bodyVisitor.visit(astBodyNode);
    }
}