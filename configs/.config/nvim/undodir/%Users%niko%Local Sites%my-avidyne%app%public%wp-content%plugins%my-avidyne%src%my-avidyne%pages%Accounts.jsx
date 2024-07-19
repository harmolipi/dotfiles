Vim�UnDo� 7'��p�Q��'Y��Y�Z�:��i��g�d���   q    * @param {object} props                              f�7    _�                     G       ����                                                                                                                                                                                                                                                                                                                                                             f�7     �   F   G          7                  console.log('onSearch:', { search });5��    F                      4      8               5�_�                     G       ����                                                                                                                                                                                                                                                                                                                                                             f�7    �         q       * @param {object} props�         q      ) * @param {Function} props.setRefreshUser�         q      $ * @param {number} props.currentPage�         q      ) * @param {Function} props.setCurrentPage�         q      # * @param {number} props.totalPages�         q      ( * @param {Function} props.setTotalPages�         q      ' * @param {Function} props.handleSearch�         q      & * @param {User[]} props.filteredUsers�         q      + * @param {Function} props.setFilteredUsers�         q      $ * @param {string} props.searchValue�         q      ) * @param {Function} props.setSearchValue�         q       * @returns {JSX.Element}�         q       */�         q      	setRefreshUser,�         q      	currentPage,�         q      	setCurrentPage,�          q      	totalPages,�      !   q      	setTotalPages,�       "   q      	handleSearch,�   !   #   q      	filteredUsers,�   "   $   q      	setFilteredUsers,�   #   %   q      	searchValue,�   $   &   q      	setSearchValue,�   &   (   q      I	const { accounts, loadingAccounts, userRole } = useContext(UserContext);�   (   *   q      %	const handlePageChange = (page) => {�   )   +   q      		setCurrentPage(page);�   *   ,   q      	};�   ,   .   q      	useEffect(() => {�   -   /   q      '		if (userRole === 'dealer_customer') {�   .   0   q      			// setFilteredUsers([]);�   /   1   q      			setTotalPages(0);�   0   2   q      
		} else {�   1   3   q      			setFilteredUsers(accounts);�   2   4   q      		}�   3   5   q      	}, [accounts]);�   5   7   q      		return (�   6   8   q      '		<div className="site-layout-content">�   7   9   q      			<h1>Accounts</h1>�   8   :   q      >			<div style={{ display: 'flex', justifyContent: 'center' }}>�   9   ;   q      				<ContentBlockContainer>�   :   <   q      @					<ContentBlock backgroundColor="transparent" shadow={false}>�   ;   =   q      
						<div�   <   >   q      							style={{�   =   ?   q      								display: 'flex',�   >   @   q      (								justifyContent: 'space-between',�   ?   A   q      								}}�   @   B   q      						>�   A   C   q      							<Search�   B   D   q      								placeholder="Search"�   C   E   q      								allowClear�   D   F   q      								size="large"�   E   G   q      								onSearch={(search) => {�   F   H   q      									setCurrentPage(1);�   G   I   q       									setSearchValue(search);�   H   J   q      
								}}�   I   K   q      								style={{�   J   L   q      									width: 200,�   K   M   q      
								}}�   L   N   q      								/>�   M   O   q      ;							<NewAccountButton setRefreshUser={setRefreshUser} />�   N   P   q      						</div>�   O   Q   q      					</ContentBlock>�   P   R   q      					<ContentBlock�   Q   S   q      						shadow={false}�   R   T   q      						padding="0"�   S   U   q      #						backgroundColor="transparent"�   T   V   q      					>�   U   W   q      						<ConfigProvider�   V   X   q      							theme={{�   W   Y   q      								token: {�   X   Z   q      									margin: 0,�   Y   [   q      )									colorBorderSecondary: '#f0f0f0',�   Z   \   q      -									boxShadow: '0 0 7px -1px #6b6b6b85',�   [   ]   q      
								},�   \   ^   q      								}}�   ]   _   q      						>�   ^   `   q      '							{loadingAccounts && <Loading />}�   _   a   q      							{!loadingAccounts && (�   `   b   q      1								<AccountsList accounts={filteredUsers} />�   a   c   q      								)}�   b   d   q      						</ConfigProvider>�   c   e   q      					</ContentBlock>�   d   f   q      					<Pagination�   e   g   q      						total={totalPages}�   f   h   q      						current={currentPage}�   g   i   q      						pageSize={1}�   h   j   q      !						onChange={handlePageChange}�   i   k   q      						hideOnSinglePage�   j   l   q      						showSizeChanger={false}�   k   m   q      					/>�   l   n   q      				</ContentBlockContainer>�   m   o   q      				</div>�   n   p   q      		</div>�   o   q   q      	);�      q   q   U     setRefreshUser,     currentPage,     setCurrentPage,     totalPages,     setTotalPages,     handleSearch,     filteredUsers,     setFilteredUsers,     searchValue,     setSearchValue,   }) {   J  const { accounts, loadingAccounts, userRole } = useContext(UserContext);       &  const handlePageChange = (page) => {       setCurrentPage(page);     };         useEffect(() => {   )    if (userRole === 'dealer_customer') {         // setFilteredUsers([]);         setTotalPages(0);       } else {   !      setFilteredUsers(accounts);       }     }, [accounts]);       
  return (   )    <div className="site-layout-content">         <h1>Accounts</h1>   A      <div style={{ display: 'flex', justifyContent: 'center' }}>           <ContentBlockContainer>   E          <ContentBlock backgroundColor="transparent" shadow={false}>               <div                 style={{                    display: 'flex',   0                justifyContent: 'space-between',                 }}               >                 <Search   $                placeholder="Search"                   allowClear                   size="large"   '                onSearch={(search) => {   $                  setCurrentPage(1);   )                  setSearchValue(search);                   }}                   style={{                     width: 200,                   }}                 />   B              <NewAccountButton setRefreshUser={setRefreshUser} />               </div>             </ContentBlock>             <ContentBlock               shadow={false}               padding="0"   )            backgroundColor="transparent"             >               <ConfigProvider                 theme={{                   token: {                     margin: 0,   2                  colorBorderSecondary: '#f0f0f0',   6                  boxShadow: '0 0 7px -1px #6b6b6b85',                   },                 }}               >   .              {loadingAccounts && <Loading />}   $              {!loadingAccounts && (   9                <AccountsList accounts={filteredUsers} />                 )}               </ConfigProvider>             </ContentBlock>             <Pagination               total={totalPages}   !            current={currentPage}               pageSize={1}   '            onChange={handlePageChange}               hideOnSinglePage   #            showSizeChanger={false}             />            </ContentBlockContainer>         </div>   
    </div>     );5��           T      T            �      A      �    o                     N                    �    n                     E                    �    m                     ;                    �    l                                         �    k                  
                
       �    j                     �
                    �    i                     �
                    �    h                     �
                    �    g                     �
                    �    f                     �
                    �    e                     w
                    �    d                  
   f
             
       �    c                  
   Q
             
       �    b                     9
                    �    a                     /
                    �    `                     �	                    �    _                     �	                    �    ^                     �	                    �    ]                     �	                    �    \                     �	                    �    [                     �	                    �    Z           	          l	      	              �    Y           	          B	      	              �    X           	          .	      	              �    W                     	                    �    V                     	                    �    U                     �                    �    T                  
   �             
       �    S                     �                    �    R                     �                    �    Q                     �                    �    P                  
   �             
       �    O                  
   }             
       �    N                     p                    �    M                     4                    �    L                     *                    �    K                                         �    J           	          
      	              �    I                     �                    �    H                     �                    �    G           	          �      	              �    F           	          �      	              �    E                     �                    �    D                     |                    �    C                     i                    �    B                     L                    �    A                     =                    �    @                     5                    �    ?                     +                    �    >                                         �    =                     �                    �    <                     �                    �    ;                     �                    �    :                  
   �             
       �    9                     q                    �    8                     2                    �    7                                         �    6                     �                    �    5                     �                    �    3                     �                    �    2                     �                    �    1                     �                    �    0                     �                    �    /                     �                    �    .                     z                    �    -                     R                    �    ,                     ?                    �    *                     :                    �    )                     "                    �    (                     �                    �    &                     �                    �    $                     �                    �    #                     �                    �    "                     z                    �    !                     j                    �                          [                    �                         K                    �                         >                    �                         -                    �                                             �                                             �                         �                    �                         �                    �                         �                    �                         ~                    �                         R                    �                         +                    �                                             �                         �                    �                         �                    �                         �                    �                         g                    �                         =                    �                         $                    5��