//========= Copyright Valve Corporation, All rights reserved. ============//
//
// Purpose: A higher level link library for general use in the game and tools.
//
//===========================================================================//

#include <tier2/tier2.h>
#include "tier0/dbg.h"
#include "filesystem.h"
#include "platform.hpp"


//-----------------------------------------------------------------------------
// These tier2 libraries must be set by any users of this library.
// They can be set by calling ConnectTier2Libraries or InitDefaultFileSystem.
// It is hoped that setting this, and using this library will be the common mechanism for
// allowing link libraries to access tier2 library interfaces
//-----------------------------------------------------------------------------
#ifdef ARCHITECTURE_IS_X86
IFileSystem *g_pFullFileSystem = 0;
#endif

//-----------------------------------------------------------------------------
// Call this to connect to all tier 2 libraries.
// It's up to the caller to check the globals it cares about to see if ones are missing
//-----------------------------------------------------------------------------
void ConnectTier2Libraries( CreateInterfaceFn *pFactoryList, int nFactoryCount )
{
	// Don't connect twice..
	Assert( !g_pFullFileSystem );

	for ( int i = 0; i < nFactoryCount; ++i )
	{
		if ( !g_pFullFileSystem )
		{
			g_pFullFileSystem = ( IFileSystem * )pFactoryList[i]( FILESYSTEM_INTERFACE_VERSION, NULL );
		}
	}
}

void DisconnectTier2Libraries()
{
	g_pFullFileSystem = 0;
}

